class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.77.0.tar.gz"
  sha256 "e32f7e32c61af67d64692ecff008d8f6da4eb80046e252f17ced8453141efa72"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7e8a298b2bf7607edd41dd688d8ca1fcc055fb094447db97272d5cc1c849ca0a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "07ef50771d8de66c56374be326e0da6050e5e109e7acb0f47a2b8543a0004c03"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8c63e5199f241da5848800ec4f5b2244fbc652cab7c08dd08cfef453fd84aac5"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
