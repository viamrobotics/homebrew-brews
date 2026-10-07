class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.11.2.tar.gz"
  sha256 "830fd07de3a1a8afe6890dd23384917f0e0fe423206b2ee937435ba32ca289b5"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 30
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a4e571a45867dda4d7c24290b4bab5fc4e8b0a1d46c0eeafec21bd6c007cd30a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a506448bd139bdfd0870414ad9ac40a164964e29cd631fae28b8b461e697c066"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e94fa4a0879d08c1a16a35db89c0be196eac6b3016f55e907aa2108d77a8eed5"
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
