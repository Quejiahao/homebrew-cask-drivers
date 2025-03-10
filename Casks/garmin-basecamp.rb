cask "garmin-basecamp" do
  on_sierra :or_older do
    version "4.7.0"
    sha256 "43d2fcd3571fff70eeca2734c56e0aae0f982bc1a7019588bd55b883cc34b16c"

    url "https://download.garmin.com/software/BaseCampforMacLegacyVersion_#{version.no_dots}.dmg"

    livecheck do
      skip "Legacy version"
    end
  end
  on_high_sierra :or_newer do
    version "4.8.12"
    sha256 "aecd4b28975169118056f5901f3db4a3a58d50c204184b7dc64919f23a19247c"

    url "https://download.garmin.com/software/BaseCampforMac_#{version.no_dots}.dmg"

    livecheck do
      url "https://www8.garmin.com/support/download_details.jsp?id=4449"
      regex(/name=["']?software_version["']?\s*content=["']?(\d+(?:\.\d+)+)["' >]/i)
    end
  end

  name "Garmin BaseCamp"
  desc "3D mapping application"
  homepage "https://www.garmin.com/en-US/shop/downloads/basecamp"

  pkg "Install BaseCamp.pkg"

  uninstall quit:    [
              "com.garmin.BaseCamp",
              "com.garmin.MapInstall",
              "com.garmin.MapManager",
            ],
            pkgutil: [
              "com.Garmin.*.BaseCamp*",
              "com.Garmin.pkg.BasecampPostflight",
              "com.Garmin.pkg.MapInstall",
              "com.Garmin.pkg.MapManager",
            ]

  zap trash: [
    "~/Library/Application Support/Garmin",
    "~/Library/Caches/Garmin",
    "~/Library/Caches/com.garmin.BaseCamp",
    "~/Library/Caches/com.garmin.MapInstall",
    "~/Library/Cookies/com.garmin.BaseCamp.binarycookies",
    "~/Library/Cookies/com.garmin.MapInstall.binarycookies",
    "~/Library/Logs/Garmin",
    "~/Library/Preferences/com.garmin.BaseCamp.plist",
    "~/Library/Preferences/com.garmin.MapInstall.plist",
    "~/Library/Preferences/com.garmin.MapManager.plist",
  ]
end
