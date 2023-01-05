class RplidarModule < Formula
  desc "Viam rplidar modular component"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rplidar.git",
    tag:      "v0.1.3",
    revision: "64ed987a850f7e15fd451239e6c0d85e9daf6675"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/rplidar.git", branch: "main"

  depends_on "go" => :build
  depends_on "swig" => :build

  def install
    system "make", "build-module"
    bin.install "bin/rplidar-module"
  end
end
