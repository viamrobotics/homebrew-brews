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
    rebuild 31
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c97327a65666ffa25dd16c9edaaf706069d853127c13d0778560b3ab9ccd5def"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ecc560d3c520e7892ecc70cdacb95ec1f43288d899120b4477b2b11910ac4173"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9b03cc34ec33e8c660e05405134d71f9ed4b705759032feb1e04ea63d1653f5d"
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
