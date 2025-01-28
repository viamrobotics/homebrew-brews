class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.60.1.tar.gz"
  sha256 "a166d4035c06fd8dab543b3ea5dff298c466c137d3ec6d075fdef20f6b27b0ec"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 17
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "301757b2b174c10b90c6177e913e5ecf197100ab4272555cbf207e73ca418ebe"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a4e967798838dd3cc054cf15c1ed257e23cc3155be65057846cbabce24d9b46e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f56c8a6ee4a6c89b5f715b7798ad7eeba0ad52550cbaefa9a716b56828c9f218"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
