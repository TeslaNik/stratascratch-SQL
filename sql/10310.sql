select MAX(total_score) - MIN(total_score) as max_diff
FROM
    (select assignment1 + assignment2 + assignment3 as total_score
    from box_scores) b;