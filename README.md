Simple test case for reproducing VirtualBox NAT bug with Vagrant.

 * https://github.com/mitchellh/vagrant/issues/516
 * https://gist.github.com/1716454

I found that my original `pip install` test case produced around 800 DNS lookups before it failed. It turns out that these alone, without the HTTP requests, are enough to freeze the NAT interface.

    dan@dan-MacPro:~/pcap$ tshark -r vbox_guest.pcap "dns.flags.response == 0" | wc -l
    798

Vagrant's Puppet provisioner will install `dig` and a shell script. The shell scripts loops a DNS query and prints an iteration count. Vagrant's shell provisioner will call the script with a hostname, in this case "github.com", and print the output on the console.

## Failing VMs

`centos_intel` and `ubuntu_intel` use the default Intel 82540EM network adapters. On these VMs the script will almost certainly hang at 380~ iterations. During this "hang time" the NAT interface will be incommunicado and any interactive SSH sessions are likely to drop. Sometimes the shell provisioner resumes on the other side of the blackout, but will hang again later and eventually exit with:

    net-ssh-2.2.2/lib/net/ssh/ruby_compat.rb:22:in `select': closed stream (IOError)

## Passing VMs

`centos_amd` and `ubuntu_amd` use AMD Am79C973 network adapters. On these VMs the script will probably continue forever until you ^C it.
