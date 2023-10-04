use std::io::{self, BufRead};

struct Point {
    x: i32,
    y: i32,
}

struct Path {
    points: Vec<Point>,
}

impl Path {
    fn add_point(&mut self, point: Point) {
        self.points.push(point)
    }
}

fn main() {
    let mut paths: Vec<Path> = Vec::new();

    for line in io::stdin().lock().lines() {
        let mut path = Path { points: Vec::new() };

        for point in line.unwrap().split(" -> ") {
            let mut split = point.split(",");
            let x: i32 = split.next()
                              .unwrap()
                              .parse()
                              .unwrap();
            let y: i32 = split.next()
                              .unwrap()
                              .parse()
                              .unwrap();

            path.add_point(Point {
                x: x,
                y: y
            });
        }

        paths.push(path);
    }

    for path in paths {
        for point in path.points {
            println!("{0},{1}", point.x, point.y);
        }
        println!("");
    }
}
