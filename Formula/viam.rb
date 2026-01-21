class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.110.0.tar.gz"
  sha256 "86fb6e8f9f8c89bd45bebd1c2b9c952bc7a5a470c66e6aa445cd18b9bf2989fd"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 55
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ec29e7dc21061f4daa24c8681d1c4bb8da1bd36314483f7e51e49b90df47ea8f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "eaf4f5e054e175ab279bf60fe3b09a8622af74b63246ab94b877416e2bc38944"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7d67c4ae22433ba0c2c9af9bcf51b69c4bb287b1a7c40d7aced7dcc68d01dc24"
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
