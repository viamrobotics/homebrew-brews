class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.130.0.tar.gz"
  sha256 "2cc0e69f26e368620ea60c9384870d6495125bb71641d12bbba0e8d573bdcae4"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 15
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fa87360d82fc772493d232e9ca96be000506013826aa683ab85eb31e8c9d48be"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1fd7f4367bacc4f5c79f0c6cb91233757cdafd7b498a479fedf1fb3fedb63a4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c672ee0f1767c7f9bfcefd385d1d8e2e9c187b3631e041529a59b698d49edc1"
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
