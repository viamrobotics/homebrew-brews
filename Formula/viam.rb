class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.72.0.tar.gz"
  sha256 "a46d57fd4cc9a60be1b0330ae09fa257694aededb695ae71a3e5551b5a9b8de0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 35
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f617d6168a1d7a6148a4f75fe8419c43aed37d86a6a1559d258e08a513dae534"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "995870b2cb3b421aa1bee61482d2865f18716c768606fa5437abe5ca8ba844f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ce76b94771b14328545f5ac0585e0c7c5192c7a42a48f2f73b16f38785bb214c"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
