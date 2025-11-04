class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.99.0.tar.gz"
  sha256 "79b072259520e428cbe53eccdfeec9aafd8e5509614fcef3a51c22abc0ca2a40"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 37
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7373b7afb857b67a4b5ddb84ab5eb66bc1e6694b2141ef44f16afba61bfa99d4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "51eb7b615ac0c7ad4d5cf3e0f58a2a5bf241356463fd968a742d9159507b589f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dc9433fb4b47145714ea235231181343c402fc699a7871648f12b3532fa9cdf3"
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
