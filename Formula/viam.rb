class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.49.0.tar.gz"
  sha256 "4784a11aef9e8e5e10953b20e04aacf9dd4928f9e23ce2d3db05855776e426b1"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1cf9e95bfde38d840cc29b5578fc82125da8cbdb8ebb55c3db7908a57ee09ee6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c84f4394a09492fe3c1a9d79e7b2078b0edf148675150d5bf386e9328fc56092"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f949ea3c830f9cc88369dfc7fe97531d8a7da867aa65fb2089e36d2bee8bf977"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
