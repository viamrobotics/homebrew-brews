class RplidarModule < Formula
  desc "A Viam rplidar modular component"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rplidar.git",
    tag: "v0.1.1",
    revision: "4df4e585ac908397b0e8ee881ec79429762ea237"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/rplidar.git", branch: "main"

  depends_on "go" => :build
  depends_on "swig" => :build
  depends_on "rplidar-sdk" => :build

  def install
    system "make", "swig"
    system "make", "build-module"
    bin.install "bin/rplidar-module"
  end
end
