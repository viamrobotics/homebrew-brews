class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.72.1.tar.gz"
  sha256 "559c20b6ba7ab5cf7bf2ae3d9b0ac46739c8ff889d1967f2a4a03fb7eceefb0a"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 36
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "eee103eb8048cfd0621a0892dd2e15718a65a4b8faa7aff7b9cb57e32c22b9f0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c9736e0f375493b17b90e82ed1653e84749bf5cdfdf91e75ecd9b4120ba5c2e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "93a894e7da5e890e846427483b3b04296dcc90d7eda2dde71fd4497009ae3636"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
