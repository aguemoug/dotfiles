let
  users = import ./shared/users.nix;
in
{
  workstation = {
    hostname = "workstation";
    dir = users.default;
    arch = "x86_64-linux";
    user = users.default;
  };

  mini = {
    hostname = "sof-mini";
    dir = users.default;
    arch = "x86_64-linux";
    user = users.default;
  };

  laptop = {
    hostname = "sof-thinkpad";
    dir = users.default;
    arch = "x86_64-linux";
    user = users.default;
  };

}
