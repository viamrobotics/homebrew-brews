class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.68.1.tar.gz"
  sha256 "d69abca86d541accce37d10dd8b54798d4880366c2eb7c668c4b7a7dc5ab3e6e"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 29
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9c5bf3ec4c9e0cacbc744f31cf0dc689972dbf189836310061465acadc9941fd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b1ff03944889fc581223a0ed7505f9c85e8a4b870e3b0c0f06adcf63a9990e73"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e4f18f6488bf342408d0ddb2b19ef5181fc86a5f8523cf39d3f8ee51826310d8"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
