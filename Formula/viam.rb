class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.107.0.tar.gz"
  sha256 "719eeb787bebeb306e74f046e2aca4a855907b005b49e88c8156c9a1ecac90c6"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 47
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1910ae5db601d42d144334bbab1f9eb2b5b72c9ec2eb75667c62601ac3eda0a9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e5b2784b8572e01bba7a8be2027e3cd5d9cf7b817130bf20166977bb762fcd96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "023a95afa9a1bf0680a9fa3fcd4256e1c05c2cfa49ba37727f4c90bf54b65b20"
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
