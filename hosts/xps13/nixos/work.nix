{
  security.pam.loginLimits = [
    {
      domain = "florent";
      type = "soft";
      item = "nofile";
      value = "8192";
    }
  ];
}