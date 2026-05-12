class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.126.0.tar.gz"
  sha256 "6ad15939f839a9e03232c4cee18cfdac3f3bf5be3a12dd541dd744780b18be0b"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dbffe049ab2bca006869c624bd08d762a6651840fbc93c351f598648e825542e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b86113abfdf28c29d010ec5d68164afddf3c603ee5e8b0c444a61b514468e37e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "636b648d3dfd6ca0c643ae2bf7b9a930fd0ac1f29238e802a4820c87736e233e"
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
