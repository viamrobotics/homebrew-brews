class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.6.0.tar.gz"
  sha256 "ea08cf358d0305ee52ea2ac37f5e5fb8d9e43ef4f19f1d0df3e063c992fee579"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 24
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d61d314612d2a0a116d4836e346bb065e4edbe77b97ecad02b3238765247b79c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8e6ba9df045376eb697f57ed3c143aff4ade9cafd95516a2a728baaab25d1f47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aecb718aea5b841fcad859ecbbd2df3becf629b916b287e94c6d99f3eee61bae"
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
