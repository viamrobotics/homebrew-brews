class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.123.0.tar.gz"
  sha256 "53e77215e88c60a0714d289067c89c199d2942647c9513268f7474a02a0a6432"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3a8cc16139b5a513bd8233c8c58a5a95efa99de3246f454183fc6c895810f030"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "185570e61b5139acef630360ac70930de95243f840fb0850b7791dc25ef44b0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "351333f87ab66af31aa25477fd73541fd49d08b35615263433df582c1bf75ad9"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
