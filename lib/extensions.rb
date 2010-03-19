  # add lchop and classify / constantize methods to string class via a monkey patch
  class String

    # Remove the first character from the string.
    def lchop
      s = self.gsub(/^./, "")
    end
    def classify
      self.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
    end
    def constantize()
      unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ self.classify
        raise NameError, "#{self.inspect} is not a valid constant name!"
      end

      Object.module_eval("::#{$1}", __FILE__, __LINE__)
    end

  end

  