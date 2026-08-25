class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "d91499e5ed56905fd1d77a1bc691209ecda03c7241f76e72a1cfe73e739f3261"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 23
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9c9673a01b6ed5e8fb9bbe54ac784274fd638e81635e9b169eecc5e09527a7ce"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "790adae55d66145891e037be43199669cdd322cc744140a093eb2094f5f15599"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "52e96e43bae3fde141a301b9de3533ccbc0dc0663864c23aab4c74f7f454e28e"
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
