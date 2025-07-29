class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.86.0.tar.gz"
  sha256 "608a0426df056e4cd11a4de4e628348c06d5dd0eadd3eea5031d12515be87dfc"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 16
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a3e955303dfbf39821ffdd827b059eef53de4d642078a1caa64bc8336d375a30"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6774a2093c4c4f8e5ac936cdcb78886d5c640d7c901ddb44f9dc845dc3292270"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de53533adb79f0696a7d49af84aedfa42a01024ba9faab3c1a2785c1f5127eb0"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
