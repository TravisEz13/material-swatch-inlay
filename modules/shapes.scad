module rounded_square(x, y, radius, color = "orange") {
    offset(radius)
    offset(-radius)
    color(color)
    square([x, y]);
}