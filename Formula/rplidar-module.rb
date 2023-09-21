class RplidarModule < Formula
  desc "Viam rplidar modular component"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rplidar.git",
    tag:      "v0.1.14",
    revision: "05b18067df1c2e3f4c058999be68ac3de030576c"
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
