cask "reolink-client" do
  version "8.8.4,2023,02,011051551675248715,3375"
  sha256 :no_check

  url "https://home-cdn.reolink.us/wp-content/uploads/#{version.csv[1]}/#{version.csv[2]}/#{version.csv[3]}.#{version.csv[4]}.dmg",
      verified: "home-cdn.reolink.us/"
  name "Reolink Client"
  homepage "https://reolink.com/software-and-manual/"

  livecheck do
    url "https://reolink.com/wp-json/reo-v2/download/?lang=en&type=clients&viaReoAPI=true&lang=en"
    strategy :page_match do |page|
      download = JSON.parse(page)["data"]["downloads"].find { |d| d["type"] == "mac_client" }
      match = download["url"].match(%r{/(\d+)/(\d+)/(\d+)\.(\d+)\.dmg}i)
      "#{download["version"]},#{match[1]},#{match[2]},#{match[3]},#{match[4]}"
    end
  end

  app "Reolink.app"

  uninstall quit:   "com.reolink.client",
            delete: "/Library/Logs/DiagnosticReports/Reolink Client_*.wakeups_resource.diag"

  zap trash: [
    "~/Library/Application Support/Reolink Client",
    "~/Library/Preferences/com.reolink.client.plist",
    "~/Library/Saved Application State/com.reolink.client.savedState",
  ]
end
