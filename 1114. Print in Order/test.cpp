#include <mutex>
#include <condition_variable>

class Foo {
private:
    std::mutex m;
    std::condition_variable cv;
    int step = 1;   // which function is allowed to run next

public:
    Foo() {}

    void first(function<void()> printFirst) {
        std::unique_lock<std::mutex> lock(m);
        // step is already 1, so no waiting needed
        printFirst();
        step = 2;
        cv.notify_all();
    }

    void second(function<void()> printSecond) {
        std::unique_lock<std::mutex> lock(m);
        cv.wait(lock, [this] { return step == 2; });
        printSecond();
        step = 3;
        cv.notify_all();
    }

    void third(function<void()> printThird) {
        std::unique_lock<std::mutex> lock(m);
        cv.wait(lock, [this] { return step == 3; });
        printThird();
    }
};
