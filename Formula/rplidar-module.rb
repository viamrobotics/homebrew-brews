class RplidarModule < Formula
  desc "A Viam rplidar modular component"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rplidar.git",
    tag: "v0.1.0",
    revision: "50c5527efe1910575cb4b3445871395232a41cb6"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/rplidar.git", branch: "main"

  depends_on "go" => :build
  depends_on "swig" => :build
  depends_on "rplidar-sdk" => :build

  def install
    system "make", "swig"
    system "make", "build-module"
    bin.install "bin/rplidar_module"
  end
end