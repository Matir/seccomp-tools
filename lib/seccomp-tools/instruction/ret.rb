require 'seccomp-tools/instruction/base'

module SeccompTools
  module Instruction
    # Instruction ret.
    class RET < Base
      # Decompile instruction.
      def decompile
        "return #{ret_str}"
      end

      # See {Instruction::Base#symbolize}.
      # @return [[:ret, (:a, Integer)]]
      def symbolize
        [:ret, code & 0x18 == SRC[:a] ? :a : k]
      end

      # See {Base#branch}.
      # @return [[]]
      #   Always return an empty array.
      def branch(*)
        []
      end

      private

      def ret_str
        _, type = symbolize
        return 'A' if type == :a
        str = ACTION.invert[type & 0x7fff0000].to_s
        str += "(#{type & 0xffff})" if str == 'ERRNO'
        str
      end
    end
  end
end
