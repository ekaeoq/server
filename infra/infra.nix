{unit, ...}:
{
  pools = {
    "default" = {
      start = true;
      autoStart = true;
      path = "/var/lib/libvirt/images";
      volumes = [
        {
          name = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "bastion-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "bastion";
          backing = "bastion-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "gateway";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "builder";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "prometheus";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "minimal";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "proxy";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
        {
          name = "calendar";
          backing = "minimal-base-v2";
          capacity = unit.GiB 8;
        }
      ];
    };
  };

  networks = {
    "private-network" = {
      start = true;
      autoStart = true;
      bridge = "vprivate";
      address = "10.17.3.1";
      dns = "8.8.8.8";
      prefixLength = 24;
      dhcp = {
        start = "10.17.3.2";
        end = "10.17.3.254";
        hosts = [
          {mac = "02:a2:cd:0c:46:78"; hostname = "spum-platform"; address = "10.17.3.110";}
          {mac = "02:38:60:94:88:cc"; hostname = "spum-mqtt";     address = "10.17.3.111";}
          {mac = "02:c4:28:97:46:27"; hostname = "grades";        address = "10.17.3.120";}
          {mac = "02:17:14:14:5a:c4"; hostname = "ps";            address = "10.17.3.130";}
          {mac = "02:aa:bc:09:52:6d"; hostname = "esp";           address = "10.17.3.140";}
          {mac = "02:59:e1:4f:03:bf"; hostname = "usatour";       address = "10.17.3.150";}
          {mac = "02:a5:f8:7e:1d:b3"; hostname = "bioma";         address = "10.17.3.180";}
          {mac = "02:af:e7:1b:e5:de"; hostname = "gb";            address = "10.17.3.190";} 
          {mac = "02:33:74:0c:86:ee"; hostname = "ears";          address = "10.17.3.200";}
          {mac = "02:da:bb:9f:f8:54"; hostname = "collab";        address = "10.17.3.210";}
        ];
      };
    };
  };

  domains = {
    "bastion" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "bastion";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "bastion.l";
          address = "10.17.3.100";
        }
      ];
      directInterfaces = [
        {
          device = "eno1";
        }
      ];
    };
    "gateway" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "gateway";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "gateway.l";
          address = "10.17.3.101";
        }
      ];
      directInterfaces = [
        {
          device = "eno1";
        }
      ];
    };
    "builder" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 10;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "builder";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "builder.l";
          address = "10.17.3.102";
        }
      ];
    };
    "prometheus" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "prometheus";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "prometheus.l";
          address = "10.17.3.103";
        }
      ];
    };
    "minimal" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "minimal";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "minimal.l";
          address = "10.17.3.220";
        }
      ];
    };
    "proxy" = {
      start = true;
      autoStart = true;
      memory = unit.MiB 500;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "proxy";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "proxy.l";
          address = "10.17.3.221";
          bandwidth = {
            inbound = {average = unit.MB 1; burst = unit.MiB 5;};
            outbound = {average = unit.MB 1; burst = unit.MiB 5;};
          };
        }
      ];
    };
    "calendar" = {
      start = true;
      autoStart = true;
      memory = unit.GiB 1;
      vcpu = 1;
      disks = [
        {
          device = "vda";
          pool = "default";
          volume = "calendar";
        }
      ];
      networkInterfaces = [
        {
          network = "private-network";
          hostname = "calendar.l";
          address = "10.17.3.160";
        }
      ];
    };
  };
}
