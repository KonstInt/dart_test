import 'dart:math';

class TSP {
  int numberOfCities;
  List<List<int>> distanceMatrix;
  late Map<String, int> memo;

  TSP(this.numberOfCities, this.distanceMatrix) {
    memo = {};
  }

  int tsp(List<int> path, int currentCity) {
    if (path.length == numberOfCities) {
      return distanceMatrix[path.last][path.first];
    }

    String key = '$path-$currentCity';

    if (memo.containsKey(key)) {
      // Если значение уже было вычислено, возвращаем его
      return memo[key]!;
    }

    int minDistance = double.maxFinite.toInt();

    for (int nextCity = 0; nextCity < numberOfCities; nextCity++) {
      if (!path.contains(nextCity)) {
        List<int> newPath = List.from(path);
        newPath.add(nextCity);

        int currentDistance =
            distanceMatrix[currentCity][nextCity] + tsp(newPath, nextCity);

        minDistance = min(minDistance, currentDistance);
      }
    }

    // Сохраняем значение в мемо и возвращаем его
    memo[key] = minDistance;
    return minDistance;
  }
}

void main() {
  List<List<int>> distanceMatrix = [
    [0, 10, 15, 20],
    [10, 0, 35, 25],
    [15, 35, 0, 30],
    [20, 25, 30, 0],
  ];

  int numberOfCities = distanceMatrix.length;

  TSP tspSolver = TSP(numberOfCities, distanceMatrix);

  int startingCity = 0;

  List<int> initialPath = [startingCity];

  int optimalDistance = tspSolver.tsp(initialPath, startingCity);
  print("Optimal Distance: $optimalDistance");
}
