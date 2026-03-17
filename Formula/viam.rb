class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.117.0.tar.gz"
  sha256 "d8ceaef30eac2de46b27ace442548ded219bc3a7b120cbfd78f57053cd2efa74"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 61
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "43ac103916caa885d60b6fd100a363022588dda12d39e978a720051bb7020cef"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "db3d85211647e8e3e861c6e57552266086d4747f1d26ead2c1a57bd8e056974c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b1d667a284a73992ced10620a78e61ffc465b717991711e02dbae514983f0c31"
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
