class RplidarModule < Formula
  desc "Viam rplidar modular component"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rplidar.git",
    tag:      "v0.1.16",
    revision: "1a698aa9f99f5d45f2f43443982af1138d586010"
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
