class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.77.0.tar.gz"
  sha256 "e32f7e32c61af67d64692ecff008d8f6da4eb80046e252f17ced8453141efa72"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8dbc6c39a8fe1686e715048de6ab4b9a93af7addc25a921590daad8ea10d37a8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0977a828ea53fdc5015a8dc30bbd3d789229ebc41dae47a8c65693dfb2359874"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4eb1b49a631645b6dbf1bd17c6a8914dfb6e18de28fdb9c84a4c56d011ab0798"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
