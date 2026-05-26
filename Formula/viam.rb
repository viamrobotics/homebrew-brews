class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.128.0.tar.gz"
  sha256 "4c20f2f3f2f712588f3afb5b72baa30cee8acaf2d843cfa5b4a4e11f16acdb64"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 9
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5ff5dbad2fa19bed3f1720347cbabbfaddc7797d02ab9d612947b9ac6b4c78d0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d020aa655f981150df15aaa2f68ed1eaf3b671d91e52336cdf2d1872cb5cf527"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e2145b5d47d371d214322a9451facbff2bbe2928aa35e4a3ad7616b414d6cb1c"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
    generate_completions_from_executable(bin/"viam", "completion")
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
