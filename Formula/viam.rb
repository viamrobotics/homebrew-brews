class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.71.0.tar.gz"
  sha256 "595dbd573d2513598ea34cc3dfe74900355992a3bcbc1bb18d00294508433cdd"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 32
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7d3d7e45353bd5fb2e038ba70eb536dae2bb189b89dc470c62c4b98a0c914a07"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "797e6b4fc1ca5e389b049a1b5ab551794e291cd1b3c09b57816d200d892be360"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "32e1c0abe1884f5b19becd77a77ea2cd45b8359a57a5ac804f633d7fe03528ee"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
