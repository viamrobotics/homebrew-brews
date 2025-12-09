class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.105.0.tar.gz"
  sha256 "374003dbe0beac96a31264288b3b365d0d125446d2c9ab961c4a148874519087"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 45
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "300b0f9887e8119fc3be2395fbedc625d339330b2e9e0a843b8575ccd643583a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5a48af827e6b45b5e1ed9db94b5592b75a15775c1fe51aa26a6eedf6e4f88d4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a4539977e46439ca02837cd6ad536c58d984a55b5fe40d14623b34c865a50e33"
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
