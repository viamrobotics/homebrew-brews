class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.128.1.tar.gz"
  sha256 "c73d4f6ed0b3f1c1d6a27c8873496e21fdb60df0edef3afc6101e50b3a342547"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 11
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6b323e92d4be25b4cdad24d3881a234f1613cc3bf00904d7308e2d0fbef1281c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5078783db40533f9ce1e9054d6f619a6b130feae5a05724d4a749f9d1c6df9c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "94266c65ca8116a7d2228f360b2268da2268e89713d53006af149f8cc556a33c"
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
