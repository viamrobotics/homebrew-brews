class RplidarModule < Formula
  desc "Viam rplidar modular component"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rplidar.git",
    tag:      "v0.1.4",
    revision: "0086aed1b00dd9f7b9cb564cfd4665325ad8afec"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/rplidar.git", branch: "main"

  depends_on "go" => :build
  depends_on "swig" => :build

  def install
    system "make", "build-module"
    bin.install "bin/rplidar-module"
  end
end
