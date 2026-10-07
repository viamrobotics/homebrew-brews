class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.11.1.tar.gz"
  sha256 "279f9cb465451d3ea2c4628a74bb7fcd46d04e575d3d7a9c10e3b52ec89c09ce"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 29
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e50d262c9c6b63067f313782ae7b257d8e928f0ea1cf05e0812f636571b2bff3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d028d714511e65e045e8ada8cc3b7f1cc1ab2b18992d1ccee0a4761637121ff5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0e07b3383dcbf335cb4746dbc0194ad43956180f0fa79defffc9d9309ec7e433"
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
