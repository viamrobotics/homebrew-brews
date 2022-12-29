class RplidarSdk < Formula
  desc "Rplidar SDK library"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rplidar.git",
    tag: "v0.1.0",
    revision: "50c5527efe1910575cb4b3445871395232a41cb6"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/rplidar.git", branch: "main"

  depends_on "go" => :build

  def install
    sdk_version = "v1.12.0"
    if OS.mac?
      os = "Darwin"
    elsif OS.linux?
      os = "Linux"
    end
    system "make", "build-sdk"
    lib.install "gen/third_party/rplidar_sdk-release-#{sdk_version}/sdk/output/#{os}/Release/librplidar_sdk.a"
  end
end