# = Stringを拡張して標準出力に色をつける
class String
  include Term::ANSIColor
end

# = deployログを吐き出すクラス
#  @author Tetsuya Ohta
#  ログレベルに応じて出力をする。
#  CUIでの動作を重視し、標準出力に記録しつつ出力を行う。
#
#  #TODO: logディレクトリが無い場合は落ちるため、logディレクトリをあらかじめ用意しておくこと。
#
# [Usage]
#
# require 'app_logger'
# logger.info "hogehoge"
#
class AppLogger
  include Singleton

  PRINT_COLOR = {
    info: :green,
    error: :red,
    warn: :yellow,
  }

  # = I/Fを動的に定義します。
  #   後ほどANSIカラーが変わった場合等に柔軟に対応するためにdefine_methodを使います。
  class << self
    [:info, :warn, :error].each do |log_level|
      define_method log_level do | message |
        instance.output log_level, message
      end
    end
  end

  def logger
    @logger ||= begin
                  logger = ActiveSupport::Logger.new File.join("./log", "#{Date.today.to_s.gsub(/\-/,'')}.log")
                  logger.level = 1
                  logger
                end
  end

  def output (log_level, message)
    _message = format log_level, message: message + "\n"

    print _message.send(PRINT_COLOR[log_level]) 
    logger.info _message.chop!
  end

  def format(log_level, message: message)
    %([#{Time.now.to_s}] ::  #{message})
  end
end

# = グローバルから呼べる様に、loggerメソッドをObjectクラスへ追加する
# #NOTE: すでにloggerが存在するアプリケーションには組み込まないでください。
# 例）railsのActiveRecordやActionController
class Object
  def logger
    AppLogger
  end
end
