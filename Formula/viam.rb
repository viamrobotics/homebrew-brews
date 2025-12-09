class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.105.0.tar.gz"
  sha256 "374003dbe0beac96a31264288b3b365d0d125446d2c9ab961c4a148874519087"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 44
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a8a738bdeba89185eeb26877fc4f7cc1085e4e9caae4768bad390822fe17c5a7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bcecbf782ab4df289e26feffe6c5aeefe375ca8bf2319b30e8dd83a8f95c3ab5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e5eb5e7b42701b6ee15de9fc59c3138ff217e21dce472c6fb469653c6deb0e76"
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
