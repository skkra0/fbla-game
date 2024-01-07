using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
public class PlayerController : MonoBehaviour
{
    public float moveSpeed = 1f;
    public float collisionOffset = 0.01f;
    public ContactFilter2D movementFilter;

    SpriteRenderer spriteRenderer;
    Vector2 movementInput;
    Rigidbody2D rb;
    List<RaycastHit2D> castCollisions = new List<RaycastHit2D>();

    Animator animator;
    // Start is called before the first frame update
    void Start() {
        rb = GetComponent<Rigidbody2D>();
        animator = GetComponent<Animator>();
        spriteRenderer = GetComponent<SpriteRenderer>();
    }


     private void FixedUpdate() {
        // If movement input not 0, try to move
        if (movementInput != Vector2.zero) {
            bool success = TryMove(movementInput);

            if (!success && movementInput.x > 0)
            {
                success = TryMove(new Vector2(movementInput.x, 0));
            }

            if (!success && movementInput.y > 0)
            {
                success = TryMove(new Vector2(0, movementInput.y));
            }
            animator.SetBool("isMoving", success);
        } else
        {
            animator.SetBool("isMoving", false);
        }

        // set direction of sprite to mvt direction
        if (movementInput.x < 0) {
            spriteRenderer.flipX = true;
        } else if (movementInput.x > 0)
        {
            spriteRenderer.flipX = false;
        }

        
    }

    private bool TryMove(Vector2 direction)
    {
        int count = rb.Cast(direction, movementFilter, castCollisions, moveSpeed * Time.fixedDeltaTime + collisionOffset);
        if (count == 0)
        {
            rb.MovePosition(rb.position + direction * moveSpeed * Time.fixedDeltaTime);
            return true;
        }
        return false;
    }
    void OnMove(InputValue movementValue) {
        movementInput = movementValue.Get<Vector2>();
    }
}
