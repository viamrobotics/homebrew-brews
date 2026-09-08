class RplidarModule < Formula
  desc "Viam rplidar modular component"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rplidar.git",
    tag:      "v0.1.21",
    revision: "1c7ed041fbb98416c47d9a9b7cbb992c52e62e81"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/rplidar.git", branch: "main"

  depends_on "go" => :build
  depends_on "swig" => :build
  depends_on "jpeg"

  def install
    system "make", "build-module"
    bin.install "bin/rplidar-module"
  end
end
