Store a single value in memory with expiration

Install
=======
    sudo gem install mini_memory_store

Usage
=====

    # use it to cache results
    class Foo
      def expensive_stuff
        memory_store.cache{ ..something expensive.. }
      end

      private

      def memory_store
        @memory_store ||= MiniMemoryStore.new(:expires_in => 30.seconds)
      end
    end

    store = MiniMemoryStore.new
    store.set 1
    store.get == 1
    store.cache{2} == 1
    store.clear
    store.cache{2} == 2

Author
======
[Michael Grosser](http://grosser.it)  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...
