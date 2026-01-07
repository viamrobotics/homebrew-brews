class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.108.2.tar.gz"
  sha256 "8e3e4b26d40fa8ba9f593159be50b295a06f7a2d23c84cc11a8da3cb1c8abe84"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 51
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1d6ef174a411d52bf9f86db08ccc82825c3994323faf0b787caa5af74719d04d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "18437124df27903731f34ba1c1d0c189096393e3336b78e167f97ea65d9885fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4b6b8b0bd519ded0cd79d7f2cb0c584f315145bd2d4ff081cffc541d71011d35"
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
