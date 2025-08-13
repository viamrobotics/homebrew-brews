class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.88.1.tar.gz"
  sha256 "0ad8a3c5e66f2ecbb1f0902fa6de617ee88b2a845690ee63740a0864e9b41e90"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 21
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "660d1573590f9b436c8f04a899532d444e2e03117bb8d86ab11c20908a480026"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "faae795bfd73cac15d77cf55d3eb2292be484db9a38fd44be15991951016a233"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2abeaf22b8b0d980a406dc813e5fe47cfbf2035a8849982c761421898f27557"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
