class RplidarModule < Formula
  desc "Viam rplidar modular component"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rplidar.git",
    tag:      "v0.1.20",
    revision: "58eb42040bc22c55f7dc99984f3f6229102913fc"
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
