class GrpcRuby < Formula
  homepage "http://www.grpc.io/"
  head "https://github.com/grpc/grpc.git"
  url "https://github.com/grpc/grpc/archive/release-0_6_0.tar.gz"
  version "0.6.0"
  sha256 "0671c8b264bd0b087b7699da24b4251fb998657ceb516aa672419aa709f6fb19"

  depends_on "grpc"

  def install
    system 'gem', 'install', 'grpc'
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test grpc`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
