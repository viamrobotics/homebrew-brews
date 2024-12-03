class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.53.0.tar.gz"
  sha256 "ad5ca353c8a40c9cbf701ae02d1a68006fa065533cae2d1c181c8c90e494ced3"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 9
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8c56092fd74be10ce795a131669d41a59033ed433a1e6af53cd79781de2de973"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cd8432663958da100b3b08c3c41549c3ef61878907dc75ec2e00b2bcebcc9d83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0fa8f3b8ecda4851be23dc9e5054cf6f9acab681a3afef291da86cdbb8bd86ff"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
